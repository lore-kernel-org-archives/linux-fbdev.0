From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Wed, 11 Jan 2012 11:16:28 +0000
Subject: Re: [PATCH] video: s3c-fb: Add device tree support
Message-Id: <CAJuYYwRSO9OuiLNddOa+KLSkGwOAp3yHcrQZXSk_k2+oxtEDPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
 <20120110045219.GA5433@sirena.org.uk>
In-Reply-To: <20120110045219.GA5433@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On 10 January 2012 10:22, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 10, 2012 at 01:31:47AM +0530, Thomas Abraham wrote:
>
>> +Required properties:
>
>> +- gpios: The gpios used to interface with the external LCD panel.
>
> This isn't terribly informative for the user - which GPIOs and in what
> order are they specified? =A0Looking at the code it looks like pin mux
> configuration so just some wording saying it's a list of pins to be used
> for the framebuffer function.

Ok. I will modify the sentence to mean that it is list of gpios used
by framebuffer controller for data/timing interface with the lcd
panel. Thanks for your review.

Regards,
Thomas.
