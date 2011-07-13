From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 07:52:38 +0000
Subject: Re: [PATCH] video: output: remove video_output_{register,unregister}
Message-Id: <20110713075237.GA13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110706150251.30204.26171.stgit@mj.roinet.com>
In-Reply-To: <20110706150251.30204.26171.stgit@mj.roinet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jul 06, 2011 at 11:02:51AM -0400, Pavel Roskin wrote:
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> video_output_register() and video_output_unregister() are not called
> anywhere in the kernel code.  Also remove the fallback implementation
> from the header.

I'm not sure why your signed-off-by line is above your description?

This interface seems like it was primarily used by the ACPI video code,
which dropped support for the output switching fairly recently (see
677bd810eedce61edf15452491781ff046b92edc).

If you remove the registration interface then it's not clear that there's
any point in keeping the class handling or anything else around, either.
If the entire thing is to be killed off however we'll need the ack from
the author (added to Cc).
