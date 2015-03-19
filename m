From: Joe Perches <joe@perches.com>
Date: Thu, 19 Mar 2015 18:06:07 +0000
Subject: Re: [PATCH] sm750fb: Fix C99 Comments and if else braces
Message-Id: <1426788367.21142.14.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150319173947.GA12061@amitoj-Inspiron-3542>
In-Reply-To: <20150319173947.GA12061@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, 2015-03-19 at 23:09 +0530, Amitoj Kaur Chawla wrote:
> The edits have been made to remove C99 Comments and properly indent
> the if-else statements in the file while taking care of the braces according to
> Linux coding style.

Please scan your proposed patches with checkpatch
and fix possible style defects before sending them.




