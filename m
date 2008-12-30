From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [jekhor@gmail.com: Metronome specifications]
Date: Tue, 30 Dec 2008 23:56:22 +0800
Message-ID: <45a44e480812300756m2adbe0dfg2a401f8d92939d43@mail.gmail.com>
References: <20081230154614.GA30164@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LHgxH-0000vJ-9g
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Dec 2008 15:56:27 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LHgxD-0003rb-OC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Dec 2008 15:56:27 +0000
Received: by ewy14 with SMTP id 14so5939178ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 30 Dec 2008 07:56:23 -0800 (PST)
In-Reply-To: <20081230154614.GA30164@jeknote.loshitsa1.net>
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

Hi Yauhen,

My apologies for the delay in replying. As you can imagine, life is
busy at Christmas and New Year and trying to clean out my patch box.
Yes, I will be happy to help in any way that I can. I think it is
great that you're doing the work to get the prs-505 supported. I
unfortunately have no documentation that I can pass along but will be
happy to take a look at any code.

Ok, in response to the technical questions, can you please post the
code for the board driver here. For the other people who also asked
similar questions about broadsheet and other controllers, please post
your questions and code here on the mailing list rather than to me
alone. The fbdev mailing list is the right place for all of us to work
together on this.

Thanks,
jaya

On Tue, Dec 30, 2008 at 11:46 PM, Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> Excuse me for double posting, but can you send any response to me, ever
> negative? I also wrote to eInk and they refer me to you as expert in
> this area.
>
> ----- Forwarded message from Yauhen Kharuzhy <jekhor@gmail.com> -----
>
> From: Yauhen Kharuzhy <jekhor@gmail.com>
> To: Jaya Kumar <jayakumar.lkml@gmail.com>
> Cc: linux-fbdev-devel@lists.sourceforge.net
> Subject: Metronome specifications
> Date: Wed, 24 Dec 2008 23:57:36 +0200
>
> Hi!
>
> I write board driver for Sony PRS-505 book reader display controller and
> need some help. Controller seems to be respond for first command only (RDY is
> 0 before powerup and 1 after and it won't change on any other steps).
> I cannot localize cause of problem because controller behaviour is
> undocumented and non-trivial. I compare Sony's driver and metronomefb,
> and don't understand differences due lack of documentation.
>
> Can you help to find any documentation for Metronome or, if it
> is distrubuted under NDA, explain some moments for me?
>
> How dimensions of image and size of buffer are set in controller? What
> does define positions of command buffer, waveforms, image data etc. in
> controller memory? What are arguments of config (0xCC10) command mean?
>
> I feel that I will find answers for most of this questions after some
> time, but with documentation it will happen soon...
>
> ----- End forwarded message -----
>
> --
> Yauhen Kharuzhy         jekhor _at_ gmail.com
>                        JID: jek@jabber.ru
>
> A: No
> Q: Should I quote below my post?
>

------------------------------------------------------------------------------
