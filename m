From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 25 Jun 2015 11:56:31 +0000
Subject: Re: [PATCH v3 11/19] staging: sm750fb: consistent spacing around operators
Message-Id: <20150625115618.GC13366@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
 <1435163120-3253-11-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1435163120-3253-11-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

On Wed, Jun 24, 2015 at 09:25:12AM -0700, Juston Li wrote:
> fixes checkpatch.pl error:
> ERROR: need consistent spacing around ''
little bit confused.
1) Your subject says consistent space around operators but here it says
	around ''
2) Considering that you are giving consitent space around operators, then
	i think you have missed few operators like '|','&',':' in this
	patch.

regards
sudip
