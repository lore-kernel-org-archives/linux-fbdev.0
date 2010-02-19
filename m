From: Greg KH <gregkh@suse.de>
Date: Fri, 19 Feb 2010 00:37:26 +0000
Subject: Re: [PATCH 9/10] udlfb: explicit dependencies and warnings
Message-Id: <20100219003724.GC29873@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245195.4353.3304.camel@bernie-aspireone>
In-Reply-To: <1266245195.4353.3304.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Feb 18, 2010 at 02:49:34PM -0800, Bernie Thompson wrote:
> Hi Greg,
>=20
> On Thu, Feb 18, 2010 at 8:01 AM, Greg KH <greg@kroah.com> wrote:
> > This patch adds the warning to the build:
> > =A0 =A0 =A0 =A0drivers/staging/udlfb/udlfb.c:65:2: warning: #warning me=
ssage "FB_SYS_* in kernel or module option to support fb console"
>=20
> The intent is you'd get that warning when:
>=20
> * You're building udlfb as a module outside of full kernel rebuild
> * You don't have a dependency you need (for full functionality)
>=20
> If you were doing a full kernel build, Kconfig (as of this patch)
> knows the dependencies as should pull them in.
>=20
> In this case, your kernel headers say you don't have
> CONFIG_FB_SYS_IMAGEBLIT (which is part of the "virtual framebuffer
> driver" ops set of BLIT, FILL, etc. which has a lot of (IMHO
> incorrectly strong) warnings around it in Kconfig not to enable, since
> several drivers are now dependent.
>=20
> That dependency is needed for framebuffer consoles (fbcon) to work
> properly in udlfb with the current implementation. This post gives a
> little background on the different types of framebuffer clients:
> http://plugable.com/2010/01/30/linux-kernel-framebuffer-rendering-apis/
>=20
> So you either need to recompile your kernel to get this dependency, or
> live without framebuffer console functionality (which many people
> don't care about -- but some do a lot).
>=20
> Failing compile completely generated a strong response from some users
> -- they didn't want to recompile their whole kernel to get a single
> module, if the dependency was for functionality they didn't care
> about.
>=20
> Keeping the #ifdefs but getting rid of the #warnings would mean
> silently loosing functionality, which would throw people off later.
>=20
> So two questions:
> * Is there evidence the #warning is getting triggered in a case where
> it shouldn't (you actually have the dependency)?
> * Does the wording of the #warning need to be better - any suggestions
> for future patches?

I must have done something wrong, built only the drivers/staging/udlfb/
directory or something, with a full kernel build I no longer see this
issue.

Very sorry for the noise, and thanks for the full response.

greg k-h
