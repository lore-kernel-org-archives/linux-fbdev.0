From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 09 Mar 2015 13:29:13 +0000
Subject: Re: [PATCH v2 4/4] staging: sm750fb: fix undeclared function
Message-Id: <20150309132913.GH10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425886506-8643-4-git-send-email-sudipm.mukherjee@gmail.com>
 <20150309124222.GE10964@mwanda>
 <20150309125503.GB11724@sudip-PC>
In-Reply-To: <20150309125503.GB11724@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 06:25:03PM +0530, Sudip Mukherjee wrote:
> Actually I thought, since this is a vendor crude driver there will be many such changes, so if i can combine some changes together then atleast the number of patches can be kept low and also i thought of clubbing these changes together as Joe Perches once told me "Don't get carried away with patch type separation" (reference: https://lkml.org/lkml/2015/1/1/2).

How to break up patches is more art than science.  I wouldn't have
complained about the minor extra white space changes except that I was
already going to email you about breaking my scripts.

regards,
dan carpenter

