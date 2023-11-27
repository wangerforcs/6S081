看书时在一系列acquire(&p->lock)的操作纠结了好久，后来才明白。
刚开始想法是：
yield和sleep等调用sched来使用内核scheduler进行进程切换的函数，在切换前要获取进程锁；
而scheduler调度程序、wakeup更改进程状态也要获取进程锁，那被切换的进程还怎么唤醒和被重新调度？这不是矛盾了吗？

尝试问了GPT，它胡说一气。后来认真想想又看了书上的细节：
> swtch returns on the scheduler’s stack as though scheduler’s swtch had returned (kernel/proc.c:463). The scheduler continues its for loop,  finds a process to run, switches to it, and the cycle repeats.

才恍然大悟，自已理解错了调度器的使用，实际上使用swtch进入调度器程序后，交换上下文并ret，从scheduler的swtch之后执行，相当于scheduler的swtch返回了，其实之前已经获得了锁。

从正向看就是
> Each CPU calls scheduler() after setting itself up.

> There is one case when the scheduler’s call to swtch does not end up in sched. allocproc
sets the context ra register of a new process to forkret (kernel/proc.c:515), so that its first swtch “returns” to the start of that function. forkret exists to release the p->lock; otherwise, since the new process needs to return to user space as if returning from fork, it could instead start at usertrapret.

最初scheduler获取进程锁后调度由allocproc创建的进程，此时进程上下文的ra为forkret，因此进入forkret函数，会释放进程锁，也就不会导致我最开始疑问的死锁问题。

而这些其实文章中都有，第一次看的时候可能没太注意。而且确实模糊理解上没问题，文档中大部分也和操作系统学的差不多，本来改变进程的状态肯定就要持有锁，但深究发现自己实际上对进程调度具体机制没有很清楚，还是有点tricky的。


对于书中给出的PV操作的例子，为什么选择使用lock来保护计数，而不是采用原子加减法？
而且明明xv6中acquire(&lock)本来就是通过test_and_set原子操作构建自旋锁，为什么还要费这么大劲去实现sleep和wakeup优化的PV操作？

当然，如果对用户来说要用更高层次的函数来实现信号量，那确实可以用锁和条件变量来实现信号量，而且sleep(void *chan, struct spinlock *lk)和cond_wait(cond_t *cv, lock_t *lock)的实现也具有相似之处。

proc.c文件好好看好好学


