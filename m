From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 17:05:01 +0000
Subject: Re: [PATCH] fb: Reduce priority of resource conflict message
Message-Id: <20110406170452.GA18426@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301953194-6706-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1301953194-6706-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Apr 06, 2011 at 10:50:04AM +1000, Dave Airlie wrote:
> On Tue, Apr 5, 2011 at 7:39 AM, Matthew Garrett <mjg@redhat.com> wrote:
> > It's expected that efifb will conflict with a native driver, so the
> > handover message should be informational rather than an error.
> >
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 
> Acked-by: Dave Airlie <airlied@redhat.com>
> 
Applied, thanks.
