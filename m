From: Robert William Fuller <hydrologiccycle@gmail.com>
Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on video planes
Date: Sun, 05 Oct 2008 07:57:20 -0400
Message-ID: <48E8ABA0.8070305@gmail.com>
References: <200810031633.43418.hverkuil@xs4all.nl>	<5A47E75E594F054BAF48C5E4FC4B92AB02D603E9FB@dbde02.ent.ti.com> <20081005081931.1dfdd7b4@pedra.chehab.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20081005081931.1dfdd7b4@pedra.chehab.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Mauro Carvalho Chehab wrote:
> On Fri, 3 Oct 2008 20:10:36 +0530
> "Shah, Hardik" <hardik.shah@ti.com> wrote:
>>> 3) Some of the lines are broken up rather badly probably to respect the
>>> 80 column maximum. Note that the 80 column maximum is a recommendation,
>>> and that readability is more important. So IMHO it's better to have a
>>> slightly longer line and break it up at a more logical place. However,
>>> switching to video_ioctl2 will automatically reduce the indentation, so
>>> this might not be that much of an issue anymore.
>> [Shah, Hardik] 80 column was implemented to make the checkpatch pass.  Point noted and will take care of this.
> 
> The 80 column rule isn't there for nothing.

The 80 column rule is retarded.  None of this code needs to fit on punch 
cards, nor is it COBOL.  There are legitimate reasons to have lines 
longer than 80 columns.  No matter how simple a program is, it is likely 
to have an expression that is longer than 80 characters.  Most people's 
displays are wider than 80 columns these days.  Vertical real estate is 
at a greater premium than horizontal real estate these days with wider 
aspect ratio monitors, which better approximate the human field of 
vision.  Why make people scan more than one line for a single expression?

