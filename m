From: Greg KH <gregkh@suse.de>
Date: Fri, 12 Aug 2011 19:34:05 +0000
Subject: Re: [PATCH] Add support for SMSC UFX6000/7000 USB display adapters
Message-Id: <20110812193405.GB10770@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Aug 12, 2011 at 12:06:55PM -0700, Bernie Thompson wrote:
> On Fri, Aug 12, 2011 at 8:56 AM, Greg KH <gregkh@suse.de> wrote:
>=20
>     You can do the same for your calls to pr_debug() and other pr_* calls.
>     If you note in the header file for those functions, it suggests that
>     drivers should always call the dev_* versions instead of teh "raw" pr=
_*
>     functions, as you do have access to a struct device within your drive=
r.
>=20
>=20
> A little background from udlfb: we weren't able to stick with dev_* calls=
 100%,
> because udlfb needed to survive USB device removal and the freeing of the
> USB-initiated device structure. This is because the framebuffer device ne=
eded
> to outlive it if a client was holding on to it. =A0In other words, it's b=
orn a
> two-headed beast (usb and fbdev), but the two faces of the device are kil=
led
> off independently based on remaining ref counts. =A0So there are prints i=
n there
> which will fault if converted to dev_* without this in mind.
>=20
> Because of this, we had originally created our own dl_* wrapper around th=
e pr_
> macros.
>=20
> Then a later patch initiated by Paul (fbdev maintainer) changed those to
> uncustomized pr_ macros with a goal of uniformity with other drivers. =A0=
And that
> code is what SMSC started from.
>=20
> So there's some complexity behind the choices here. =A0It might be good t=
o keep
> common strategies between udlfb and smsc's driver, as the issues to consi=
der
> are the same.

Ok, thanks for the background information, that makes sense.

But for stuff like the usb probe() call, that should always be dev_* as
you really do have a proper pointer.  So when you do have a valid struct
device, you should use it.

Although a lot of the pr_info() calls should be downgraded to pr_debug()
I imagine, to keep things from being so noisy.

thanks,

greg k-h
