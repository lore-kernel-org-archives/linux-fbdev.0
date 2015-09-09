From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Wed, 09 Sep 2015 21:08:11 +0000
Subject: [PATCH 02/13] Always expose __SYSCALL(... fork ...)
Message-Id: <1441832902-28993-3-git-send-email-palmer@dabbelt.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: 3chas3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-atm-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>

I think this change actually doesn't do anything: __NR_fork was still
being defined either way, and on my machine fork() in <unistd.h> comes
from libc.

That said, I don't think there's any way to determine this
automatically, so this at least quiets the checker.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/asm-generic/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index e016bd9b1a04..e027ef7aa01f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -865,11 +865,11 @@ __SYSCALL(__NR_uselib, sys_uselib)
 __SYSCALL(__NR__sysctl, sys_sysctl)
 
 #define __NR_fork 1079
-#ifdef CONFIG_MMU
+#if !defined(__KERNEL__) || defined(CONFIG_MMU)
 __SYSCALL(__NR_fork, sys_fork)
 #else
 __SYSCALL(__NR_fork, sys_ni_syscall)
-#endif /* CONFIG_MMU */
+#endif /* !__KERNEL__ || CONFIG_MMU */
 
 #undef __NR_syscalls
 #define __NR_syscalls (__NR_fork+1)
-- 
2.4.6

