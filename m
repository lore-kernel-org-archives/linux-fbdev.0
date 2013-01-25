From: Alexander Holler <holler@ahsoftware.de>
Date: Fri, 25 Jan 2013 18:49:26 +0000
Subject: [PATCH 1/3] semaphore: introduce down_timeout_killable()
Message-Id: <1359139768-32294-1-git-send-email-holler@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50F2A310.5010006@ahsoftware.de>
In-Reply-To: <50F2A310.5010006@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, Alexander Holler <holler@ahsoftware.de>

The name says it all, it's like down_timeout() but returns on fatal signals
too.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 include/linux/semaphore.h |  2 ++
 kernel/semaphore.c        | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index dc368b8..b508d4d 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -41,6 +41,8 @@ extern int __must_check down_interruptible(struct semaphore *sem);
 extern int __must_check down_killable(struct semaphore *sem);
 extern int __must_check down_trylock(struct semaphore *sem);
 extern int __must_check down_timeout(struct semaphore *sem, long jiffies);
+extern int __must_check down_timeout_killable(struct semaphore *sem,
+						long jiffies);
 extern void up(struct semaphore *sem);
 
 #endif /* __LINUX_SEMAPHORE_H */
diff --git a/kernel/semaphore.c b/kernel/semaphore.c
index 4567fc0..4a5e823 100644
--- a/kernel/semaphore.c
+++ b/kernel/semaphore.c
@@ -37,6 +37,8 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long jiffies);
+static noinline int __down_timeout_killable(struct semaphore *sem,
+						long jiffies);
 static noinline void __up(struct semaphore *sem);
 
 /**
@@ -169,6 +171,35 @@ int down_timeout(struct semaphore *sem, long jiffies)
 EXPORT_SYMBOL(down_timeout);
 
 /**
+ * down_timeout_killable - acquire the semaphore within a specified time or
+ * until a fatal signal arrives.
+ * @sem: the semaphore to be acquired
+ * @jiffies: how long to wait before failing
+ *
+ * Attempts to acquire the semaphore.  If no more tasks are allowed to
+ * acquire the semaphore, calling this function will put the task to sleep.
+ * If the semaphore is not released within the specified number of jiffies,
+ * this function returns -ETIME. If the sleep is interrupted by a fatal signal,
+ * this function will return -EINTR. If the semaphore is successfully acquired,
+ * this function returns 0.
+ */
+int down_timeout_killable(struct semaphore *sem, long jiffies)
+{
+	unsigned long flags;
+	int result = 0;
+
+	raw_spin_lock_irqsave(&sem->lock, flags);
+	if (likely(sem->count > 0))
+		sem->count--;
+	else
+		result = __down_timeout_killable(sem, jiffies);
+	raw_spin_unlock_irqrestore(&sem->lock, flags);
+
+	return result;
+}
+EXPORT_SYMBOL(down_timeout_killable);
+
+/**
  * up - release the semaphore
  * @sem: the semaphore to release
  *
@@ -253,6 +284,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long jiffies)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, jiffies);
 }
 
+static noinline int __sched __down_timeout_killable(struct semaphore *sem,
+							long jiffies)
+{
+	return __down_common(sem, TASK_KILLABLE, jiffies);
+}
+
 static noinline void __sched __up(struct semaphore *sem)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
-- 
1.7.11.7

