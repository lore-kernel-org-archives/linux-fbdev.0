From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 16 Nov 2016 06:15:40 +0000
Subject: Re: [GIT PULL] fbdev fixes for 4.9
Message-Id: <87r36cx84z.fsf@concordia.ellerman.id.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b74835d1-b878-55ec-65d3-dd3766a5b194@ti.com> <CA+55aFwygcJpoEWWZyB5R3e25=842EuQ0wxFvdn5uyhtEo9Kkw@mail.gmail.com> <c1cf7b43-0cf8-3f7e-5ad8-56c3c5589563@ti.com>
In-Reply-To: <c1cf7b43-0cf8-3f7e-5ad8-56c3c5589563@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mathieu Malaterre <malat@debian.org>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> [ Unknown signature status ]
> On 14/11/16 18:25, Linus Torvalds wrote:
>> On Mon, Nov 14, 2016 at 3:44 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>
>>> Please pull two fbdev fixes for 4.9.
>> 
>> No.
>> 
>> This has obviously never even been test-compiled. It introduces two
>> new annoying warnings.
>
> Sorry about that. I dropped the patch for now and here's a new pull request.
>
> I did test compile, and I would have noticed errors but I missed the warnings
> (I blame the flu...). I need to improve my testing methods, but I couldn't find
> a way to add -Werror to kernel builds.

You can turn it on per-directory, eg:

diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index ee8c81405a7f..2ee96810d26d 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -4,6 +4,8 @@
 
 # Each configuration option enables a list of files.
 
+subdir-ccflags-y := -Werror
+
 obj-y				+= core/
 
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o


cheers
