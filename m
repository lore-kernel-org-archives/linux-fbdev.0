From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [jekhor@gmail.com: Metronome specifications]
Date: Thu, 1 Jan 2009 04:42:56 +0800
Message-ID: <45a44e480812311242y632e8efl6816e895b48a797e@mail.gmail.com>
References: <20081230154614.GA30164@jeknote.loshitsa1.net>
	<45a44e480812300756m2adbe0dfg2a401f8d92939d43@mail.gmail.com>
	<20081231121659.GA1761@jeknote.loshitsa1.net>
	<20081231125936.GA18373@jeknote.loshitsa1.net>
	<20081231141645.GA24153@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LI7u9-0002sb-HW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 20:43:01 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LI7u7-0007aL-RB for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 20:43:01 +0000
Received: by ewy14 with SMTP id 14so6586412ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Dec 2008 12:42:57 -0800 (PST)
In-Reply-To: <20081231141645.GA24153@jeknote.loshitsa1.net>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Dec 31, 2008 at 10:16 PM, Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> On Wed, Dec 31, 2008 at 02:59:36PM +0200, Yauhen Kharuzhy wrote:
>
>> static int am200_wait_event(struct metronomefb_par *par)
>> {
>>       return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
>> }
>
> I also noticed error in your am200_wait_event() implementation:
>
> metronomefb supposed that return value of met_wait_event() will be zero
> on successful case, but wait_event_timeout() returns zero on timeout.
>

ah, ok, good catch, I had not noticed this mistake. I will fix this
asap or you can also submit a patch to do this if possible.

Thanks,
jaya

------------------------------------------------------------------------------
