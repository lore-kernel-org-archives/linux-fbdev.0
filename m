From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Sat, 03 Mar 2012 16:57:32 +0000
Subject: Re: [PATCH 0/3] video: s3c-fb: Rearrange the elements in platform data
Message-Id: <CAJuYYwRnB=6S6DmtMrX-S_LF9ayjFSHT=p5J8S1YyGMZkpaG9w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
	<20120303163000.GA1495@sirena.org.uk>
In-Reply-To: <20120303163000.GA1495@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, jg1.han@samsung.com, ben-linux@fluff.org, patches@linaro.org

On 3 March 2012 22:00, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Mar 03, 2012 at 09:20:05PM +0530, Thomas Abraham wrote:
>> This patchset rearranges the elements in the platform data of the s3c-fb
>> driver with the intent of adding device tree support to the driver in
>> subsequent patches.
>
> It seems somewhat surprising that none of these updates touch any
> platform data for any existing machines - are no machines using any of
> the features being updated?

The third patch in this series includes platform data updates for the
Exynos4210 based Origen board. If the first two patches in this series
are acceptable, I will submit another version of this patchset which
would include updates to all existing machines that have platform data
for s3c-fb driver. I did not want to modify all the existing machines
without being sure of the acceptance of the first two patches.

Thanks,
Thomas.
