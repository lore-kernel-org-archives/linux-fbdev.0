From: Joe Perches <joe@perches.com>
Date: Sun, 05 Mar 2017 13:39:48 +0000
Subject: Re: [PATCH 0/3] multiple checkpatch issues
Message-Id: <1488721188.2179.52.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>, sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, 2017-03-05 at 16:54 +0530, Arushi Singhal wrote:
> Improve readability by fixing multiple checkpatch.pl
> issues in sm750fb driver. 

Remember to prefix the subject of the 0/n patch with the subsystem.

> Arushi Singhal (3):
>   staging: sm750fb: fixes add blank line after function/struct/union/enum declarations
>   staging: sm750fb: function prototype argument should have an identifier name
>   staging: sm750fb: Alignment should match open parenthesis
> 
>  drivers/staging/sm750fb/ddk750_display.h |  3 +-
>  drivers/staging/sm750fb/ddk750_mode.c    | 69 ++++++++++++++++----------------
>  drivers/staging/sm750fb/ddk750_mode.h    |  4 +-
>  drivers/staging/sm750fb/ddk750_power.h   |  3 +-
>  drivers/staging/sm750fb/sm750.h          |  2 +-
>  drivers/staging/sm750fb/sm750_cursor.c   |  3 ++
>  6 files changed, 45 insertions(+), 39 deletions(-)
> 
