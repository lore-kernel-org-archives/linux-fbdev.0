From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 3/6] pxa: fix pxa168 lcd controller
	vsync/hsync timing error
Date: Tue, 10 Nov 2009 13:18:42 +0800
Message-ID: <7c34ac520911092118y3f125b93j9b8b8d70f76432f7@mail.gmail.com>
References: <7c34ac520911022245x7f002a7at846a835dfded550c@mail.gmail.com>
	<f17812d70911032320k379dc7laab1979a3b452969@mail.gmail.com>
	<7c34ac520911041815k6555e209r4039ae9f97c9ebca@mail.gmail.com>
	<f17812d70911081939nf30b893vc8a9b3cf821fc78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <niej0001@gmail.com>) id 1N7j82-0000h1-M8
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Nov 2009 05:18:54 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7j7w-0003Hp-7q for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Nov 2009 05:18:54 +0000
Received: by pwi12 with SMTP id 12so413128pwi.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Nov 2009 21:18:42 -0800 (PST)
In-Reply-To: <f17812d70911081939nf30b893vc8a9b3cf821fc78@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org

2009/11/9 Eric Miao <eric.y.miao@gmail.com>:
>>> Could you please help double check this? My understanding is
>>> FB_SYNC_VERT_HIGH_ACT means it's a positive pulse covering all the
>>> valid HSYNCs, and a rising edge of VSYNC means a start of the frame.
>>>
>>> However, CFG_INV_VSYNC is '1' means the opposite.
>>>
>>
>> My understanding is that high active means high level trigger new
>> frame/line. Below page support my point if it is not wrong.
>>
>> http://www.arcadecollecting.com/info/Sync_fixing.txt
>>
>
> Tried to find the specific diagram in the spec on what CFG_INV_* means
> but failed, can you help verified this with an oscilloscope and let know
> the result? This is a fix then, and I'd like it to get into .32, sorry for late
> reply.
>

Hi, Eric
If do not set CFG_INV_VSYNC and CFG_INV_HSYNC bits, controller output
is as below in oscilloscope.

                  ||               ||                ||
.._________||_________||_________||____... HSYNC (active high)

                                                    _____
                                                     |     |
.._____________________________|     |_... VSYNC (active high)

So I should mark HSYNC_HIGH and VSYNC_HIGH in platform code and keep
driver code as  below original code.
       x |= (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 0x00000008;
       x |= (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 0x00000004;

Thanks!

Jun

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
