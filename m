From: Greg KH <gregkh@suse.de>
Date: Fri, 19 Feb 2010 00:31:52 +0000
Subject: Re: [PATCH 5/10] udlfb: Add functions to expose sysfs metrics and
Message-Id: <20100219003152.GA29873@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245168.4353.3300.camel@bernie-aspireone>
In-Reply-To: <1266245168.4353.3300.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Feb 18, 2010 at 03:03:37PM -0800, Bernie Thompson wrote:
> Hi Greg,
>=20
> On Thu, Feb 18, 2010 at 7:57 AM, Greg KH <greg@kroah.com> wrote:
>=20
> > All new sysfs files will need a Documentation/ABI/ patch as well to
> > explain the files.
>=20
> I'll construct an additional patch to document the edid file (this
> aught to be a standardized thing for all framebuffers, anyway - and
> others have done similar/same).

If it's a standard framebuffer file, it should be documented already.
If not, that's a simple patch to get upstream :)

> And I'll do a separate one for the individual metrics if they're kept
> in sysfs in the future.

thanks, but I don't think they should be, and it looks like you don't
either.

> >> metrics_misc
> >
> > This isn't. =A0sysfs files are "one value per file". =A0If you want to =
do
> > something else, like this file, I suggest using debugfs instead.
>=20
> The metrics stuff is a good candidate for moving to debugfs, I guess,
> in a future patch. For now, anything in that set which violates sysfs
> guidelines (metrics_misc) aught to just be removed, I guess.
>=20
> These metrics have already been very helpful for comparing different
> rendering algorithms, for debugging, and it's very helpful for
> gathering info from end-users that may not have anything other than
> sysfs set up. There are so many different hardware/software scenarios
> that there's often no way to have any sense of what's happening
> without more detailed instrumentation like this.

Then use debugfs for this, that is what it is explicitly for.  All
distros mount the thing now, so you can easily get information from it
from people who do not build their own kernels.  It's quite powerful.

thanks,

greg k-h
