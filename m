From: David Herrmann <dh.herrmann@gmail.com>
Date: Mon, 12 May 2014 10:34:04 +0000
Subject: Re: [PATCH] uvesafb: abort initialization if video=uvesafb is not set
Message-Id: <CANq1E4QgkN46oRC_eLZnS4EJzKTLbDTyHG2-4j7onFy_OFM3og@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396791873-22606-1-git-send-email-lxnay@sabayon.org>
In-Reply-To: <1396791873-22606-1-git-send-email-lxnay@sabayon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

On Sun, Apr 6, 2014 at 3:44 PM,  <lxnay@sabayon.org> wrote:
> From: Fabio Erculiani <lxnay@sabayon.org>
>
> This patch makes possible to ship kernels with both vesafb and uvesafb
> in order to guarantee a smooth transition to uvesafb and cope with
> potential incompatibiles introduced by uvesafb making possible to disable
> it via cmdline.
>
> In case both vesafb and uvesafb are built-in, the kernel will try to
> initialize both, which makes possible to select the wanted one using
> either video=vesafb:... or video=uvesafb:....
> In this way, old distro installations will keep working as before while
> new ones can adopt video=uvesafb.

Why would you want vesafb _and_ uvesafb built-in? Ship them as modules
and let users blacklist the modules they don't want. I mean the
problem you describe is specific to distros. Embedded devices or other
specific use-cases can explicitly disable any unwanted module. And for
distros I cannot see why we should support both as built-in modules.

_Iff_ you want this as in-kernel option, I'd recommend looking at the
sysfb stuff. uvesafb could easily claim the vesa-framebuffer and thus
unload any generic drivers like vesafb.

Thanks
David
