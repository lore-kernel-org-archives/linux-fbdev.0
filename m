From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [jekhor@gmail.com: Metronome specifications]
Date: Thu, 1 Jan 2009 04:38:07 +0800
Message-ID: <45a44e480812311238n614c38c2v6e0006e4b8b8591c@mail.gmail.com>
References: <20081230154614.GA30164@jeknote.loshitsa1.net>
	<45a44e480812300756m2adbe0dfg2a401f8d92939d43@mail.gmail.com>
	<20081231121659.GA1761@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LI7pa-0005Fc-6r
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 20:38:18 +0000
Received: from nf-out-0910.google.com ([64.233.182.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LI7pW-0002PU-Um for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Dec 2008 20:38:18 +0000
Received: by nf-out-0910.google.com with SMTP id g16so691392nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Dec 2008 12:38:13 -0800 (PST)
In-Reply-To: <20081231121659.GA1761@jeknote.loshitsa1.net>
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

On Wed, Dec 31, 2008 at 8:16 PM, Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> On Tue, Dec 30, 2008 at 11:56:22PM +0800, Jaya Kumar wrote:
>> Hi Yauhen,
>>
>> My apologies for the delay in replying. As you can imagine, life is
>> busy at Christmas and New Year and trying to clean out my patch box.
>> Yes, I will be happy to help in any way that I can. I think it is
>> great that you're doing the work to get the prs-505 supported. I
>> unfortunately have no documentation that I can pass along but will be
>> happy to take a look at any code.
>>
>> Ok, in response to the technical questions, can you please post the
>> code for the board driver here. For the other people who also asked
>> similar questions about broadsheet and other controllers, please post
>> your questions and code here on the mailing list rather than to me
>> alone. The fbdev mailing list is the right place for all of us to work
>> together on this.
>
> OK. I am sorry for my impatience.

No, no, you musn't apologize. I know I am slow, especially in
answering hard questions. :-) I will try to do better. It is one of my
resolutions for 2009.

>
> I just wrote a "new style" (for 2.6.28 kernel) board driver using of
> the existing imxfb driver similar to you am200epd board driver. I found two
> problems:
> 1) the metronomefb driver initializes before imxfb driver and a
> kernel Oops caused in the setup_fb() function because the board.host_fbinfo is not
> initialized yet. For prevent this, I placed a call of my prs505_presetup_fb()
> function immediately after the fb_register_client() call.

Okay, I think I understand what you're saying and yes, that sounds
like a reasonable solution.

>
> 2) the LCD controller in IMX SoCs supports LCD panels with height <= 511 (9 bit in
> LCD_SIZE register). In the original Sony driver this height is 312. As I
> suppose, it is half of the real height because LCD controller uses 16 bit
> per pixel. I set yres in my prs505_fb_info to 622 / 2.

This sounds familiar to me. There's also an alignment restriction on
the the X width which I think I had to deal with on pxa255 because
LCCR1 required 16bpp and a minimum 32-pixel alignment which meant 416
=> 832. Are you having to do the same there or does iMX handle this
differently?

>
> Now metronomefb initializes but nothing happen on the screen.

Ok, does this mean the ready signal not reasserting is solved?

>
> I attached my board driver.
> Sony driver, if needed, can be found here:
> http://users.openinkpot.org/~jekhor/8track20070714.tgz

Ok, I will look at both of this.

Thanks,
jaya

------------------------------------------------------------------------------
