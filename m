From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Sun, 18 Nov 2012 16:35:01 +0000
Subject: Re: video: pull request for branch "cfa-10049-3.7-oled-driver"
Message-Id: <20121118173501.4fe52c7b@skate>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352993527-9113-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1352993527-9113-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Andrew, Greg,

On Thu, 15 Nov 2012 16:32:06 +0100, Maxime Ripard wrote:

> Since these patches have been around for a few months without any comment,
> please pull the following branch.

We have been sending the below code for 2-3 months without reply or
comments from the fbdev maintainer other than "I will look at it some
day". It is a simple 400 lines driver, so nothing really horrible
to review.

We already contacted Greg directly about this situation, who suggested
resending the driver, which we did. Now we sent a formal pull request
last week, and still no answer. Would it be possible to get this driver
merged for 3.8 ?

Of course, we're willing to rework, fix and modify the driver as
needed, if comments are being made.

Thanks a lot,

Thomas

> The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:
> 
>   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/crystalfontz/cfa_10036_kernel.git cfa-10049-3.7-oled-driver
> 
> for you to fetch changes up to 353b74485bd80950b4beea1497fa234d3277e4e8:
> 
>   video: Add support for the Solomon SSD1307 OLED Controller (2012-10-22 12:35:02 +0200)
> 
> ----------------------------------------------------------------
> Maxime Ripard (1):
>       video: Add support for the Solomon SSD1307 OLED Controller
> 
>  .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
>  drivers/video/Kconfig                              |   13 +
>  drivers/video/Makefile                             |    1 +
>  drivers/video/ssd1307fb.c                          |  407 ++++++++++++++++++++
>  4 files changed, 445 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
>  create mode 100644 drivers/video/ssd1307fb.c

-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
