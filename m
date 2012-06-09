From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 09 Jun 2012 21:28:44 +0000
Subject: Re: [PATCH 0/6] drivers: randconfig patches for kernel 3.5
Message-Id: <201206092128.45064.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339194280-27475-1-git-send-email-mathieu.poirier@linaro.org>
 <201206090013.27149.arnd@arndb.de> <4FD3482B.5050004@gmx.de>
In-Reply-To: <4FD3482B.5050004@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Saturday 09 June 2012, Florian Tobias Schandinat wrote:
> > 
> > I just realized that most of these are for the same subsystem
> > (framebuffer), so you should have kept the respective mailing list
> > and maintainer on Cc (added now). 
> > 
> > The mg_disk driver is not listed in the MAINTAINERS file but
> > has an author email listed in the file itself.
> > 
> > I can take the mg_disk patch into the arm-soc tree as a fix,
> > but I'd prefer the other patches to go through the framebuffer
> > tree.
> 
> Applied all (including the backlight patches which are usually handled
> by Andrew Morton) but the mg_disk patch.

Ok, Thanks a lot!

	Arnd

