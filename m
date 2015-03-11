From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 08:56:16 +0000
Subject: Re: [PATCH 6/6] staging: sm750fb: correct integer comparison
Message-Id: <20150311085557.GA4560@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1426007817-1884-7-git-send-email-sudipm.mukherjee@gmail.com>
 <20150311075743.GS10964@mwanda>
In-Reply-To: <20150311075743.GS10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 10:57:43AM +0300, Dan Carpenter wrote:
> On Tue, Mar 10, 2015 at 10:46:57PM +0530, Sudip Mukherjee wrote:
> >  
> > -        while((opt = strsep(&src,":")) != NULL && *opt != NULL){
> > +        while((opt = strsep(&src,":")) != NULL && *opt != 0){
> 
> Use '\0' for the NUL char.
i got a doubt while making that patch, so i checked lib/string.c and
saw both 0 and '\0' are used.

regards
sudip
> 
> regards,
> dan carpenter
