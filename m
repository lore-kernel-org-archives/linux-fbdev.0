From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Mar 2015 07:45:24 +0000
Subject: Re: [PATCH] staging: sm750fb: braces, indents, spaces fix
Message-Id: <20150313074524.GE10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150313061127.GA30820@localhost.localdomain>
In-Reply-To: <20150313061127.GA30820@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ragavendra BN <ragavendra.bn@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Mar 12, 2015 at 11:11:27PM -0700, Ragavendra BN wrote:
> This patch removes the braces for the single line if statement. It fixes
> the indent positions correctly. It fixes the spaces appropriately making the code give no
> warnings by the checpath.pl script check. Please accept.
                                            ^^^^^^^^^^^^^^
Don't put this in the changelog.

> 
> Signed-off-by: Ragavendra BN <ragavendra.bn@gmail.com>

Is your name *really* BN?

regards,
dan carpenter

