From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 02 Jul 2015 07:42:43 +0000
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Message-Id: <20150702074243.GE11824@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150702070343.GD11824@pengutronix.de> <5594E56C.3010908@ti.com>
In-Reply-To: <5594E56C.3010908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 02, 2015 at 10:17:00AM +0300, Tomi Valkeinen wrote:
>=20
>=20
> On 02/07/15 10:03, Uwe Kleine-K=F6nig wrote:
> > Hello Boris,
> >=20
> > On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
> >> This series adds support for atomic PWM update, or ITO, the capability
> >> to update all the parameters of a PWM device (enabled/disabled, period,
> >> duty and polarity) in one go.
> > on first reading the subject of your series I thought it was about
> > asserting that the newly set config is active before the call to
> > pwm_config (et al) returns. That's a problem I addressed a few times in
> > the past. I wonder if it's only me or if a different wording should be
> > used for "update all parameters with a single function call".
>=20
> In my vocabulary "blocking" means that the work is done before the
> function returns, and "atomic" means the work is done in one step.
blocking is IMHO something slightly different, maybe "synchronous" is a
good term for "done when the call returns".

For write(2) I'd say
 - blocking means to only return when the write request has reached the
   kernel, but not necessarily the medium. I.e. the caller doesn't need
   to care further; and
 - atomic means that the contents of two concurrent writers don't mix in
   the resulting file content; and
 - synchronous means that once write() returns the data is on the
   medium.

So atomic seems to be fine to use here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
