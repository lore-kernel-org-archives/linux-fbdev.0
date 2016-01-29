From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Fri, 29 Jan 2016 14:03:25 +0000
Subject: [PATCH tip v7 4/7] kbuild: Add option to turn incompatible pointer check into error
Message-Id: <1454076208-28354-5-git-send-email-daniel.wagner@bmw-carit.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun.feng@gmail.com>, Maik Broemme <mbroemme@plusserver.de>, Ralf Baechle <ralf@linux-mips.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>

With the introduction of the simple wait API we have two very
similar APIs in the kernel. For example wake_up() and swake_up()
is only one character away. Although the compiler will warn
happily the wrong usage it keeps on going an even links the kernel.
Thomas and Peter would rather like to see early missuses reported
as error early on.

In a first attempt we tried to wrap all swait and wait calls
into a macro which has an compile time type assertion. The result
was pretty ugly and wasn't able to catch all wrong usages.
woken_wake_function(), autoremove_wake_function() and wake_bit_function()
are assigned as function pointers. Wrapping them with a macro around is
not possible. Prefixing them with '_' was also not a real option
because there some users in the kernel which do use them as well.
All in all this attempt looked to intrusive and too ugly.

An alternative is to turn the pointer type check into an error which
catches wrong type uses. Obviously not only the swait/wait ones. That
isn't a bad thing either.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 9d94ade..adfb6a08 100644
--- a/Makefile
+++ b/Makefile
@@ -767,6 +767,9 @@ KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=3Dstrict-=
prototypes)
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=DAte-time)
=20
+# enforce correct pointer usage
+KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=3Dincompatible-pointer-types)
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS :=3D $(call ar-option,D)
=20
--=20
2.5.0

