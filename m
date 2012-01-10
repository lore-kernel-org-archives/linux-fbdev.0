From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 10 Jan 2012 04:52:20 +0000
Subject: Re: [PATCH] video: s3c-fb: Add device tree support
Message-Id: <20120110045219.GA5433@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 10, 2012 at 01:31:47AM +0530, Thomas Abraham wrote:

> +Required properties:

> +- gpios: The gpios used to interface with the external LCD panel.

This isn't terribly informative for the user - which GPIOs and in what
order are they specified?  Looking at the code it looks like pin mux
configuration so just some wording saying it's a list of pins to be used
for the framebuffer function.
