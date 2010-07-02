From: In-Ki Dae <inki.dae@samsung.com>
Subject: Re: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Date: Fri, 02 Jul 2010 01:21:12 +0000 (GMT)
Message-ID: <5572310.15091278033672605.JavaMail.weblogic@epml12>
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

Hi, Andrew,

cpu timing variables could be used generically.
now fb.h and modedb.c file have been considered only for video mode.
but the way of transfering screen data includes also command mode(cpu mode or i80 mode)
so I thought it should be added things for it to fb_varscreeninfo struct.

Could you please tell me why cpu timing variables are specific to s3c-fb?
------- Original Message -------
Sender : Andrew Morton<akpm@linux-foundation.org> 
Date   : 2010-07-02 07:26 (GMT+09:00)
Title  : Re: [PATCH 1/3] FB: Add some members for CPU Interface.

On Tue, 29 Jun 2010 19:28:14 +0900
InKi Dae <inki.dae@samsung.com> wrote:

> 
> CPU interface needs cs, wr setup, wr act and hold delay.
> I added some members for them to common framework.
> 
> Signed-off-by: InKi Dae <inki.dae@samsung.com <mailto:p.osciak@samsung.com>>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
> <mailto:kyungmin.park@samsung.com>>

These email addresses are mangled.

> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> ...
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h

The patch seems pretty specific to s3c-fb.  Is it possible and sensible
to somhow avoid adding code to generic files?  Can we push more (or
all) of these changes into s3c-fb.c or into the arch/arm support code?
