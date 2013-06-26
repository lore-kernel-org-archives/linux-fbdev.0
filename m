From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 26 Jun 2013 15:00:34 +0000
Subject: Re: [PATCH v2 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
Message-Id: <51CB0212.3050103@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <20130625150649.GA21334@arwen.pp.htv.fi>
In-Reply-To: <20130625150649.GA21334@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 06/25/2013 05:06 PM, Felipe Balbi wrote:
>> +static struct platform_driver exynos_video_phy_driver = {
>> > +	.probe	= exynos_video_phy_probe,
>
> you *must* provide a remove method. drivers with NULL remove are
> non-removable :-)

Actually the remove() callback can be NULL, it's just missing module_exit
function that makes a module not unloadable.

--
Regards,
Sylwester
