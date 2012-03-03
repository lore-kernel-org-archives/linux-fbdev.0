From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 03 Mar 2012 16:30:01 +0000
Subject: Re: [PATCH 0/3] video: s3c-fb: Rearrange the elements in platform data
Message-Id: <20120303163000.GA1495@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, jg1.han@samsung.com, ben-linux@fluff.org, patches@linaro.org

On Sat, Mar 03, 2012 at 09:20:05PM +0530, Thomas Abraham wrote:
> This patchset rearranges the elements in the platform data of the s3c-fb
> driver with the intent of adding device tree support to the driver in
> subsequent patches.

It seems somewhat surprising that none of these updates touch any
platform data for any existing machines - are no machines using any of
the features being updated?
