Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D90C433ED
	for <linux-fbdev@archiver.kernel.org>; Sun, 11 Apr 2021 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5895610C8
	for <linux-fbdev@archiver.kernel.org>; Sun, 11 Apr 2021 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhDKVoH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:44:07 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38708 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhDKVoH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 11 Apr 2021 17:44:07 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BAD2692009C; Sun, 11 Apr 2021 23:43:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B342192009B;
        Sun, 11 Apr 2021 23:43:48 +0200 (CEST)
Date:   Sun, 11 Apr 2021 23:43:48 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Martin Hostettler <textshell@uchuujin.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        jirislaby@kernel.org, Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>,
        b.zolnierkie@samsung.com, deller@gmx.de,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
In-Reply-To: <20200929171040.GB1351851@kroah.com>
Message-ID: <alpine.DEB.2.21.2104112250310.65251@angie.orcam.me.uk>
References: <000000000000226d3f05b02dd607@google.com> <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp> <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp> <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp> <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp> <20200928175956.GF24673@neutronstar.dyndns.org> <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp> <20200929105203.GG24673@neutronstar.dyndns.org> <20200929165657.GS438822@phenom.ffwll.local>
 <20200929171040.GB1351851@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 29 Sep 2020, Greg KH wrote:

> > > > >> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> > > > >> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> > > > >>
> > > > > 
> > > > > It seems this is/was used by "svgatextmode" which seems to be at
> > > > > http://www.ibiblio.org/pub/Linux/utils/console/
> > > > > 
> > > > > Not sure if that kind of software still has a chance to work nowadays.
> > > > > 
> > > > 
> > > > Thanks for the information.
> > > > 
> > > > It seems that v.v_vlin = curr_textmode->VDisplay / (MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1)
> > > > and v.v_clin = curr_textmode->FontHeight . Thus, v.v_clin is font's height and seems to be non-zero.
> > > > But according to https://bugs.gentoo.org/19485 , people are using kernel framebuffer instead.
> > > > 
> > > 
> > > Yes, this seems to be from pre framebuffer times.
> > > 
> > > Back in the days "svga" was the wording you got for "pokes svga card
> > > hardware registers from userspace drivers". And textmode means font
> > > rendering is done via (fixed function in those times) hardware scanout
> > > engine. Of course having only to update 2 bytes per character was a huge
> > > saving early on. Likely this is also before vesa VBE was reliable.
> > > 
> > > So i guess the point where this all starts going wrong allowing the X parts
> > > of the api to be combined with FB based rendering at all? Sounds the only
> > > user didn't use that combination and so it was never tested?
> > > 
> > > Then again, this all relates to hardware from 20 years ago...
> > 
> > Imo userspace modesetting should be burned down anywhere we can. We've
> > gotten away with this in drivers/gpu by just seamlessly transitioning to
> > kernel drivers.
> > 
> > Since th only userspace we've found seems to be able to cope if this ioctl
> > doesn't do anything, my vote goes towards ripping it out completely and
> > doing nothing in there. Only question is whether we should error or fail
> > with a silent success: Former is safer, latter can avoid a few regression
> > reports since the userspace tools keep "working", and usually people don't
> > notice for stuff this old. It worked in drivers/gpu :-)
> 
> This patch just ignores the ioctl and keeps on going, so userspace
> "shouldn't" notice it :)
> 
> And it's in linux-next now, so all should be good.

 So it does trigger with vgacon and my old server, which I have started 
experimenting with and for a start I have switched to a new kernel for an 
unrelated purpose (now that I have relieved it from all its usual tasks 
except for the last remaining one for which I haven't got the required 
user software ported to the new system yet):

"struct vt_consize"->v_vlin is ignored. Please report if you need this.
"struct vt_consize"->v_clin is ignored. Please report if you need this.

It continues using svgatextmode with its glass (CRT) VT to set my usual 
80x37 text mode (720x576 pixel resolution) by manipulating the VGA clock 
chip and the CRT controller appropriately for a nice refresh rate of 85Hz:

Chipset = `TVGA8900', Textmode clock = 44.90 MHz, 80x37 chars, CharCell = 9x16. Refresh = 52.51kHz/84.7Hz.

 Indeed the piece of software became less usable around Y2K as clock chip 
support stopped being added to svgatextmode for new video adapters, but 
with the advent of LCD technology and its disregard for the refresh rate 
previously driven by the pixel clock the program got its second life and I 
have used it ever since with its plain VGA driver by just manipulating the 
CRTC for the resolution required:

Chipset = `VGA', Textmode clock = 28.32 MHz, 80x37 chars, CharCell = 9x16. Refresh = 31.47kHz/49.0Hz.

(that would still work with a standard 800x600 SVGA CRT, but the refresh 
rate would make anyone's eyes cry soon; with LCD it's just awesome, and 
the VGA emulation of the actual graphics adapter turns it at the video 
output into a 1600x1200 picture at the horizontal and vertical rates of 
75KHz and 60Hz respectively, making the text produced on LCD outstanding 
while showing about the right amount of it).

 But I'm currently ~160km/100mi away from the server I have triggered this 
message with, so I cannot easily check what's going on with its VT.  And I 
can't fiddle with my production laptop (ThinkPad P51) I have with me that 
I also use svgatextmode with so much as to reboot it with a new kernel 
(plain Debian 4.19.16-1~bpo9+1 still here).

 So what's the supposed impact of this change that prompted the inclusion 
of the messages?  I can port svgatextmode (it's my own compilation anyway) 
if that is required for it to continue working correctly, but I need to 
understand the circumstances here.  I have failed to find a satisfactory 
alternative solution to vgacon and svgatextmode; the main showstopper is 
the IBM's hardware trick for a 9x16 character cell that I rely on.

  Maciej
