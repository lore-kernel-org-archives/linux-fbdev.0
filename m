From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 13 Mar 2015 05:54:42 +0000
Subject: Re: [PATCH] staging: sm750fb: braces, indents, spaces fix
Message-Id: <20150313055429.GA4979@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150313051436.GA10544@localhost.localdomain>
In-Reply-To: <20150313051436.GA10544@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ragavendra BN <ragavendra.bn@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Mar 12, 2015 at 10:14:36PM -0700, Ragavendra BN wrote:
> This patch removes the braces for the single line if statement. It fixes
> the indent positions correctly. It fixes the spaces appropriately making the code give no
> warnings by the checpath.pl script check.

your From: is still having [user] in your email address.
and you are doing too many things in a single patch. one patch should
do only one type of change.

> 
> 
> Signed-off-by: Ragavendra BN <ragavendra.bn@gmail.com>
> 
this extra blank line is not necessary here.

regards
sudip
