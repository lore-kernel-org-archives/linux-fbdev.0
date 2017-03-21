From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 21 Mar 2017 19:34:12 +0000
Subject: Re: [PATCH v2 0/2] Remove Typedefs.
Message-Id: <52786ce4-e783-0ea4-c6cb-1deb63e91b53@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>, linux-fbdev@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, speakup@linux-speakup.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com, linux-iio@vger.kernel.org

On 21/03/17 15:06, Arushi Singhal wrote:
> Typedefs are removed in sm750fb driver.
> 
> Arushi Singhal (2):
>   staging: sm750fb: Remove typedef from "typedef struct _mode_parameter_t"
>   staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"
> 
>  drivers/staging/sm750fb/ddk750_mode.c |  8 +++++---
>  drivers/staging/sm750fb/ddk750_mode.h | 19 ++++++++-----------
>  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
Please be careful to only cc linux-iio for patches with an IIO component...
