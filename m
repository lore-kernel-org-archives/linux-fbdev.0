From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Nov 2013 19:10:31 +0000
Subject: Re: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <20131118191031.GF19318@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWtrSnTHNN-7GtMWAG9gZ0HJ3ZgVZt6Cfc=q=e-5Sr-Qw@mail.gmail.com>
 <20131118185959.GE19318@pengutronix.de>
In-Reply-To: <20131118185959.GE19318@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello again,

On Mon, Nov 18, 2013 at 07:59:59PM +0100, Uwe Kleine-K=F6nig wrote:
> 	if (pgoff > screen_size || pgoff + len > screen_size)
This must be:

	if (pgoff > screen_size || len > screen_size - pgoff)

to do what I intended.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
