From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [jekhor@gmail.com: Metronome specifications]
Date: Wed, 31 Dec 2008 14:59:36 +0200
Message-ID: <20081231125936.GA18373@jeknote.loshitsa1.net>
References: <20081230154614.GA30164@jeknote.loshitsa1.net>
	<45a44e480812300756m2adbe0dfg2a401f8d92939d43@mail.gmail.com>
	<20081231121659.GA1761@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jekhor@gmail.com>) id 1LI0g2-0004rO-EV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 12:59:58 +0000
Received: from yw-out-1718.google.com ([74.125.46.157])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LI0fy-0008ER-OK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 12:59:58 +0000
Received: by yw-out-1718.google.com with SMTP id 6so2128475ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Dec 2008 04:59:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081231121659.GA1761@jeknote.loshitsa1.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>


And another question: why IRQF_TRIGGER_FALLING is used in IRQ
configuration? As I understood, RDY signal is active with high level,
and using of IRQF_TRIGGER_RISING will be reasonable.

From am200epd.c:

static int am200_setup_irq(struct fb_info *info)
{
	int ret;

	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
				IRQF_DISABLED|IRQF_TRIGGER_FALLING,
				"AM200", info->par);
	if (ret)
		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);

	return ret;
}

static irqreturn_t am200_handle_irq(int irq, void *dev_id)
{
	struct metronomefb_par *par = dev_id;

	wake_up_interruptible(&par->waitq);
	return IRQ_HANDLED;
}

static int am200_wait_event(struct metronomefb_par *par)
{
	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
}



-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek@jabber.ru

A: No
Q: Should I quote below my post?

------------------------------------------------------------------------------
