From: In-Ki Dae <inki.dae@samsung.com>
Subject: Re: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Date: Fri, 02 Jul 2010 02:35:26 +0000 (GMT)
Message-ID: <30082026.20641278038126412.JavaMail.weblogic@epml12>
Reply-To: inki.dae@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-return: prohibited
MIME-version: 1.0
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "kmpark@infradead.org" <kmpark@infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ok, andrew

I will add descriptions to these variables also apply commends of other developers.

Thank you.
------- Original Message -------
Sender : Andrew Morton<akpm@linux-foundation.org> 
Date   : 2010-07-02 10:46 (GMT+09:00)
Title  : Re: [PATCH 1/3] FB: Add some members for CPU Interface.

On Fri, 02 Jul 2010 01:21:12 +0000 (GMT) In-Ki Dae <inki.dae@samsung.com> wrote:

> Hi, Andrew,
> 
> cpu timing variables could be used generically.
> now fb.h and modedb.c file have been considered only for video mode.
> but the way of transfering screen data includes also command mode(cpu mode or i80 mode)
> so I thought it should be added things for it to fb_varscreeninfo struct.
> 
> Could you please tell me why cpu timing variables are specific to s3c-fb?

I dunno - I was just looking at the code.

I don't even know what "cpu timing variables" _are_, in the context of
video drivers.  Look at this:

> > CPU interface needs cs, wr setup, wr act and hold delay.
> > I added some members for them to common framework.

It's gobbledigook!  Please, write patch descriptions which help poor
dumb people who don't have detailed knowledge of the particular
hardware understand your patch?
