From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 11 Jan 2012 17:40:48 +0000
Subject: Re: [PATCH] video: s3c-fb: Add device tree support
Message-Id: <20120111174048.GC24213@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
 <20120110045219.GA5433@sirena.org.uk>
 <CAJuYYwRSO9OuiLNddOa+KLSkGwOAp3yHcrQZXSk_k2+oxtEDPQ@mail.gmail.com>
In-Reply-To: <CAJuYYwRSO9OuiLNddOa+KLSkGwOAp3yHcrQZXSk_k2+oxtEDPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 11, 2012 at 04:34:28PM +0530, Thomas Abraham wrote:
> On 10 January 2012 10:22, Mark Brown

> > This isn't terribly informative for the user - which GPIOs and in what
> > order are they specified? =A0Looking at the code it looks like pin mux
> > configuration so just some wording saying it's a list of pins to be used
> > for the framebuffer function.

> Ok. I will modify the sentence to mean that it is list of gpios used
> by framebuffer controller for data/timing interface with the lcd
> panel. Thanks for your review.

You probably want to mention that it's for pin muxing, the reason I
didn't get what it meant on first read was that normally GPIO means
specifically the sort of stuff handled by gpiolib.
