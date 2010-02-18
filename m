From: Bernie Thompson <bernie@plugable.com>
Date: Thu, 18 Feb 2010 22:49:34 +0000
Subject: Re: [PATCH 9/10] udlfb: explicit dependencies and warnings
Message-Id: <480988181002181449o35f50317n950890499b20bae@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245195.4353.3304.camel@bernie-aspireone>
In-Reply-To: <1266245195.4353.3304.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Greg,

On Thu, Feb 18, 2010 at 8:01 AM, Greg KH <greg@kroah.com> wrote:
> This patch adds the warning to the build:
>        drivers/staging/udlfb/udlfb.c:65:2: warning: #warning message "FB_SYS_* in kernel or module option to support fb console"

The intent is you'd get that warning when:

* You're building udlfb as a module outside of full kernel rebuild
* You don't have a dependency you need (for full functionality)

If you were doing a full kernel build, Kconfig (as of this patch)
knows the dependencies as should pull them in.

In this case, your kernel headers say you don't have
CONFIG_FB_SYS_IMAGEBLIT (which is part of the "virtual framebuffer
driver" ops set of BLIT, FILL, etc. which has a lot of (IMHO
incorrectly strong) warnings around it in Kconfig not to enable, since
several drivers are now dependent.

That dependency is needed for framebuffer consoles (fbcon) to work
properly in udlfb with the current implementation. This post gives a
little background on the different types of framebuffer clients:
http://plugable.com/2010/01/30/linux-kernel-framebuffer-rendering-apis/

So you either need to recompile your kernel to get this dependency, or
live without framebuffer console functionality (which many people
don't care about -- but some do a lot).

Failing compile completely generated a strong response from some users
-- they didn't want to recompile their whole kernel to get a single
module, if the dependency was for functionality they didn't care
about.

Keeping the #ifdefs but getting rid of the #warnings would mean
silently loosing functionality, which would throw people off later.

So two questions:
* Is there evidence the #warning is getting triggered in a case where
it shouldn't (you actually have the dependency)?
* Does the wording of the #warning need to be better - any suggestions
for future patches?

Someone could also get rid of the dependency on these functions,
(udlfb didn't used to have them), but the old implementation was
actually incorrect -- it didn't handle all required elements of the
interface, e.g. XOR ops -- where the current/new implementation is
100% correct.

Best wishes,
Bernie
