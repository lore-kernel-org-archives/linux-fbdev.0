From: Greg Kroah-Hartman <greg@kroah.com>
Date: Fri, 04 Sep 2015 01:17:10 +0000
Subject: Re: [PATCHv2] staging: sm750fb: fix improper typedef usage
Message-Id: <20150904011710.GA11017@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150831014253.GB10267@brian_archtop.etown.edu>
In-Reply-To: <20150831014253.GB10267@brian_archtop.etown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Aug 30, 2015 at 09:42:53PM -0400, Brian Stottler wrote:
> Fix typedef usage which does not comply with kernel style guidelines.

Please do this one typedef at a time to make this easier to be able to
review.

Also, don't keep "_t" at the end of structure and enum names, it doesn't
make sense anymore, right?

thanks,

greg k-h
