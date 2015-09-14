From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Mon, 14 Sep 2015 22:50:12 +0000
Subject: Re: [PATCH] Remove #ifdef CONFIG_64BIT from all asm-generic/fcntl.h
Message-Id: <55f74f24.a2eb420a.57553.fffff8c5@mx.google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <18247.1441883885@warthog.procyon.org.uk>
In-Reply-To: <18247.1441883885@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dhowells@redhat.com, arnd@arndb.de, 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org

On Thu, 10 Sep 2015 04:18:05 PDT (-0700), dhowells@redhat.com wrote:
> David Howells <dhowells@redhat.com> wrote:
>
>> Rather than iterating through all the rest of your patches and saying the same
>> thing, if there's something in a UAPI header that needs wrapping in __KERNEL__
>> to exclude it from userspace's use, then it should be transferred to the
>> non-UAPI variant of that header (which should #include the UAPI variant).
>
> I should mention that there is the odd case where this is difficult to
> achieve.  See include/uapi/linux/acct.h for an example...

OK, sorry about that.  I'm submitting a v3 that should fix these
problems.
