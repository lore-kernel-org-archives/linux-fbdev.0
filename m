From: Laine Walker-Avina <lwalkera@pasco.com>
Date: Thu, 29 Jul 2010 21:29:12 +0000
Subject: OMAP DSS2 coming out of OFF mode without restoring context
Message-Id: <AANLkTimpATpjeaq5OYf_5zy-o1ho2UxppjF6+Re9QqUb@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org

Hi,

I'm having a problem where the DSS driver isn't restoring the
framebuffer parameters after going in and out of blanking with OFF
mode enabled. The problem appears to be in dss_get_ctx_id() in that
pdata->get_last_off_on_transaction_id is 0. Commenting out the call to
dss_need_ctx_restore() in dss_clk_enable() appears to do the right
thing. I'm using the current master branch of linux-omap.

-- 
Laine Walker-Avina
Firmware Engineer
PASCO scientific
