From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Date: Thu, 1 Jul 2010 15:26:43 -0700
Message-ID: <20100701152643.41834b17.akpm@linux-foundation.org>
References: <4C29AF72.6090200@samsung.com> <4C29B1C1.2000209@samsung.com>
	<4C29CABE.9020208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C29CABE.9020208@samsung.com>
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
To: InKi Dae <inki.dae@samsung.com>
Cc: kmpark@infradead.org, linux-fbdev-devel@lists.sourceforge.net, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

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
