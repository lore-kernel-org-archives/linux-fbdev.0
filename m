From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [jekhor@gmail.com: Metronome specifications]
Date: Wed, 31 Dec 2008 16:16:45 +0200
Message-ID: <20081231141645.GA24153@jeknote.loshitsa1.net>
References: <20081230154614.GA30164@jeknote.loshitsa1.net>
	<45a44e480812300756m2adbe0dfg2a401f8d92939d43@mail.gmail.com>
	<20081231121659.GA1761@jeknote.loshitsa1.net>
	<20081231125936.GA18373@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jekhor@gmail.com>) id 1LI1sa-0002By-Pw
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 14:17:00 +0000
Received: from rn-out-0910.google.com ([64.233.170.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LI1sX-0002hJ-ME for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 14:17:01 +0000
Received: by rn-out-0910.google.com with SMTP id j66so3731487rne.9
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Dec 2008 06:16:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081231125936.GA18373@jeknote.loshitsa1.net>
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

On Wed, Dec 31, 2008 at 02:59:36PM +0200, Yauhen Kharuzhy wrote:
 
> static int am200_wait_event(struct metronomefb_par *par)
> {
> 	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
> }

I also noticed error in your am200_wait_event() implementation:

metronomefb supposed that return value of met_wait_event() will be zero
on successful case, but wait_event_timeout() returns zero on timeout.

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek@jabber.ru

A: No
Q: Should I quote below my post?

------------------------------------------------------------------------------
