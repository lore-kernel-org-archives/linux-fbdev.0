From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 16:42:51 +0000
Subject: Re: [PATCH 1/2] Support overriding fields FW tells us with the DMI data.
Message-Id: <20110406164250.GB11820@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301582030-10607-2-git-send-email-pjones@redhat.com>
In-Reply-To: <1301582030-10607-2-git-send-email-pjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 31, 2011 at 10:33:49AM -0400, Peter Jones wrote:
> Some machines apparently give us bogus linelength/stride/pitch data, so
> we need to support letting the DMI table override the supplied data.
> 
> I bet you can't guess whose machines I'm talking about.
> ---
>  drivers/video/efifb.c |  149 +++++++++++++++++++++++++++++--------------------
>  1 files changed, 88 insertions(+), 61 deletions(-)
> 
You're missing a signed-off-by here but have one on 2/2, was this
intended as an RFC?
