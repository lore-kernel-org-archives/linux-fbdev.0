From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 14 Jul 2015 13:26:53 +0000
Subject: Re: [PATCH] staging: sm750fb: coding style fixes
Message-Id: <20150714131453.GB18186@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436856371-4570-1-git-send-email-simhavcs@gmail.com>
In-Reply-To: <1436856371-4570-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 14, 2015 at 12:16:11PM +0530, Vinay Simha BN wrote:
> kernel coding style fixes for below messages from
> scripts/checkpatch.pl
> 
> WARNING: line over 80 character
> WARNING: Possible unnecessary 'out of memory' message
> WARNING: unnecessary whitespace before a quoted newline
> WARNING: Avoid line continuations in quoted strings
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: do not initialise globals to 0 or NULL
These are too many changes in a single patch. Please only do one change
in a patch. And your patch is not applying also for a change done by
eb0f4271ca18 ("drivers: staging: sm750fb: Fix "'foo * bar' should be
		'foo *bar'" errors")

Please refresh your patch against staging-testing tree.

regards
sudip
