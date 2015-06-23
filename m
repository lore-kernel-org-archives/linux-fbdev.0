From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 23 Jun 2015 08:46:13 +0000
Subject: Re: [PATCH] staging: sm750fb: remove unused variables
Message-Id: <20150623084613.GK28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150622072017.GA32220@IND12F0122>
In-Reply-To: <20150622072017.GA32220@IND12F0122>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jun 22, 2015 at 07:26:25AM +0000, Gujulan Elango, Hari Prasath (H.) wrote:
> @@ -122,7 +121,7 @@ void setChipClock(unsigned int frequency)
>  		* Sometime, the chip cannot set up the exact clock required by User.
>  		* Return value from calcPllValue() gives the actual possible clock.
>  		*/
> -		ulActualMxClk = calcPllValue(frequency, &pll);
> +		calcPllValue(frequency, &pll);

Should we get rid of calcPllValue() as well?  I guess I would prefer to
leave the warnings until someone has the answer to this.

Warnings are good because they show where the bugs are.  It's not always
the right thing to silence them.

regards,
dan carpenter

