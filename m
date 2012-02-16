From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Date: Thu, 16 Feb 2012 07:34:09 +0000
Subject: Re: [PATCH] fb_defio: add first_io callback
Message-Id: <201202160834.10972.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201112311145.47717.heiko@sntech.de>
In-Reply-To: <201112311145.47717.heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Florian,

Am Donnerstag, 16. Februar 2012, 03:27:25 schrieb Florian Tobias Schandinat:
> Hi Heiko,
>=20
> sorry for the long delay.
no problem


> On 12/31/2011 10:45 AM, Heiko St=FCbner wrote:
> > With this optional callback the driver is notified when the first page
> > is entered into the pagelist and a new deferred_io call is scheduled.
> >=20
> > A possible use-case for this is runtime-pm. In the first_io call
> >=20
> > 	pm_runtime_get()
> >=20
> > could be called, which starts an asynchronous runtime_resume of the
> > device. In the deferred_io callback a call to
> >=20
> > 	pm_runtime_barrier()
> >=20
> > makes the sure, the device is resumed by then and a
> >=20
> > 	pm_runtime_put()
> >=20
> > may put the device back to sleep.
> >=20
> > Also, some SoCs may use the runtime-pm system to determine if they
> > are able to enter deeper idle states. Therefore it is necessary to
> > keep the use-count from the first written page until the conclusion
> > of the screen update, to prevent the system from going to sleep before
> > completing the pending update.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> while I consider this patch acceptable, I don't see any reason to apply it
> as long as there is no driver actually using it.
ok, so I will keep sitting on it until my driver for the AUO-K190x epd=20
controller is ready for primetime and resubmit this patch in conjunction wi=
th=20
it.

Heiko
