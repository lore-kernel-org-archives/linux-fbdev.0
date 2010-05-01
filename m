From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 01 May 2010 14:01:30 +0000
Subject: Re: [PATCH 02/30] viafb: use proper pci config API
Message-Id: <4BDC343A.5040901@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net> <1272493051-25380-3-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-3-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Jonathan Corbet schrieb:
> +	if (viaparinfo->memsize < 0) {
> +		rc = viaparinfo->memsize;
> +		goto out_delete_i2c;
> +	}

I fear this check is wrong as

struct viafb_par {
	...
	unsigned int memsize;
	...
}

so this check would as far as I see never return true *wonders why gcc 
doesn't complain about it*
Feel free to store the result in an integer or cast it back to signed or 
whatever solution you like.


Thanks,

Florian Tobias Schandinat
