From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 25 Sep 2015 13:56:29 +0000
Subject: Re: [PATCH] fbdev: broadsheetfb: fix memory leak
Message-Id: <20150925134429.GB4799@sudip-pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442574992-31654-1-git-send-email-sudipm.mukherjee@gmail.com>
 <5603CCA0.6000702@ti.com>
In-Reply-To: <5603CCA0.6000702@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Sep 24, 2015 at 01:12:48PM +0300, Tomi Valkeinen wrote:
> 
> On 18/09/15 14:16, Sudip Mukherjee wrote:
> > On the error path we have missed releasing the firmware.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
<snip>
> 
> This looks like correct fix, but where is the firmware released when
> there is no error?
I will send v2. Usually all the memleaks will be in the error path so I
concentrate on that part. Sorry, should have looked fully.

regards
sudip
