From: Tomi Valkeinen <tomi.valkeinen@Nokia.com>
Date: Fri, 30 Jul 2010 06:57:59 +0000
Subject: Re: OMAP DSS2 coming out of OFF mode without restoring context
Message-Id: <1280473079.2427.114.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimpATpjeaq5OYf_5zy-o1ho2UxppjF6+Re9QqUb@mail.gmail.com>
In-Reply-To: <AANLkTimpATpjeaq5OYf_5zy-o1ho2UxppjF6+Re9QqUb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Laine Walker-Avina <lwalkera@pasco.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Thu, 2010-07-29 at 23:29 +0200, ext Laine Walker-Avina wrote:
> Hi,
> 
> I'm having a problem where the DSS driver isn't restoring the
> framebuffer parameters after going in and out of blanking with OFF
> mode enabled. The problem appears to be in dss_get_ctx_id() in that
> pdata->get_last_off_on_transaction_id is 0. Commenting out the call to
> dss_need_ctx_restore() in dss_clk_enable() appears to do the right
> thing. I'm using the current master branch of linux-omap.

You need to fill the func pointer in the board file:

static struct omap_dss_board_info xxx_dss_data = {
	.get_last_off_on_transaction_id = omap_pm_get_dev_context_loss_count,

 Tomi


