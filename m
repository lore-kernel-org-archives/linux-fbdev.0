From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 20 Apr 2011 09:24:36 +0000
Subject: Re: [PATCH] efifb: fix int to pointer cast warning
Message-Id: <20110420092436.GC15898@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110419094715.7888.84515.stgit@localhost6>
In-Reply-To: <20110419094715.7888.84515.stgit@localhost6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Apr 19, 2011 at 10:22:14AM -0400, Peter Jones wrote:
> On 04/19/2011 05:47 AM, Konstantin Khlebnikov wrote:
> > drivers/video/efifb.c:247: warning: cast to pointer from integer of different size
> > 
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
> 
> Looks fine to me:
> 
> Signed-off-by: Peter Jones <pjones@redhat.com>
> 
Applied, thanks.
