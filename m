From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 02 Jun 2014 07:33:26 +0000
Subject: Re: [PATCH resend 2/4] backlight: Add backlight device (un)registration notification
Message-Id: <20140602073326.GB4319@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com>
 <538323A3.1050209@redhat.com>
 <20140527092033.GF5875@lee--X1>
 <3320448.t5cXUpNSer@vostro.rjw.lan>
In-Reply-To: <3320448.t5cXUpNSer@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Jingoo Han <jg1.han@samsung.com>, 'Aaron Lu' <aaron.lu@intel.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Ben Skeggs' <bskeggs@redhat.com>, 'David Airlie' <airlied@linux.ie>, 'Zhang Rui' <rui.zhang@intel.com>, 'Len Brown' <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, 01 Jun 2014, Rafael J. Wysocki wrote:
> On Tuesday, May 27, 2014 10:20:33 AM Lee Jones wrote:
> > > On 05/26/2014 01:03 PM, Rafael J. Wysocki wrote:
> > > > On Monday, May 26, 2014 12:03:43 PM Jingoo Han wrote:
> > > >> On Thursday, May 22, 2014 6:02 PM, Lee Jones wrote:
> > > >>> On Thursday, May 22, 2014 5:45 PM, Hans de Goede wrote:
> > > >>>> On Thursday, May 22, 2014 8:31 AM, Rafael J. Wysocki wrote:
> > > >>>>> On Wednesday, May 21, 2014 10:40 PM, Hans de Goede wrote:
> > > >>>>>> Some firmware drivers, ie acpi-video want to get themselves ou=
t of the
> > > >>>>>> way (in some cases) when their also is a raw backlight device =
available.
> > > >>>>>>
> > > >>>>>> Due to module loading ordering being unknown, acpi-video canno=
t be certain
> > > >>>>>> that the backlight_device_registered(BACKLIGHT_RAW) it does fo=
r this is
> > > >>>>>> the final verdict wrt there being a BACKLIGHT_RAW device.
> > > >>>>>>
> > > >>>>>> By adding notification acpi-video can listen for backlight dev=
ices showing
> > > >>>>>> up after it has loaded, and unregister its backlight device if=
 desired.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > >>>>>
> > > >>>>> Backlight maintainer's ACK is requisite here.
> > > >>>>
> > > >>>> Agreed, which is why I send this set to all 3 the backlight main=
tainers
> > > >>>> directly on both postings.
> > > >>>>
> > > >>>> What may be helpful for them is to hear from you if you're ok wi=
th the
> > > >>>> acpi-video bits which are actually going to use this, since thos=
e will
> > > >>>> be the only user of the new backlight api (for now).
> > > >>>
> > > >>> I'm happy to apply any Backlight patches which have either Bryan =
or
> > > >>> Jingoo's Ack, as they are the reviewers for the BL subsystem.
> > > >>
> > > >> Acked-by: Jingoo Han <jg1.han@samsung.com>
> > > >>
> > > >> Lee Jones,
> > > >> Would you merge this patch into your backlight git tree?
> > > >=20
> > > > Hans, does this series depend on things that I've applied already? =
 If so,
> > > > I'd very much prefer to take this series too as a whole.
> > >=20
> > > The 3th patch in this series:
> > > " acpi-video: Unregister the backlight device if a raw one shows up l=
ater"
> > > depends on my "acpi-video: Add an acpi_video_unregister_backlight fun=
ction"
> > > patch, which you've applied to your linux-next branch already.
> > >=20
> > > As well as on the 2nd patch in this series:
> > > "backlight: Add backlight device (un)registration notification"
> > >=20
> > > So I agree that it is a good idea to take the whole series through yo=
ur tree.
> >=20
> > I'm fine with that.
> >=20
> > Rafael, could you apply the set onto an immutable branch and send me a
> > signed pull-request please?
>=20
> You can find this patch on the branch at
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-vi=
deo
>=20
> The top-most commit is 0dc6b96ac20c (ACPI / video: Add 4 new models to the
> use_native_backlight DMI list).
>=20
> Please feel free to pull from there if necessary, it is not going to be r=
ebased.

acpi-video contains 14 patches!  If we share patches in the future,
the branches really need to contain as few patches as possible.  I'm
happy to set-up a special 'mfd-pm' immutable branch for future
releases to save either one of use pulling in more patches into our
respective trees than is necessary.

Rather than pull all those patches in to the MFD tree, I'll simply run
the risk of a merge conflict this time.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
