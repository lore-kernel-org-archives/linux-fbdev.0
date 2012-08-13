From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 13 Aug 2012 18:03:14 +0000
Subject: Re: =?utf-8?B?6L2s5Y+R?= =?utf-8?Q?=3A?= Siliconmotion new kernel driver initial patch
Message-Id: <20120813180314.GE26088@phenom.dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CE6A5494DEECD498EBCD4C5488B1AFCD04CD1@CNDC08.cn.smi.ad>
In-Reply-To: <4CE6A5494DEECD498EBCD4C5488B1AFCD04CD1@CNDC08.cn.smi.ad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?QWFyb24uQ2hlbiAg6ZmI5L+K5p2w?= <aaron.chen@siliconmotion.com>
Cc: linux-fbdev@vger.kernel.org, =?utf-8?B?bWlsbC5jaGVuIOmZiOWGmw==?= <mill.chen@siliconmotion.com>, =?utf-8?B?TWFuZHkuV2FuZyDnjovlsJHlqpo=?= <Mandy.Wang@siliconmotion.com>, dri-devel@lists.freedesktop.org, =?utf-8?B?UGF1bC5DaGVuIOmZiOazog==?= <paul.chen2@siliconmotion.com>, =?utf-8?B?Y2Flc2FyLnFpdSDoo5jotZvmtbc=?= <caesar.qiu@siliconmotion.com>, =?utf-8?B?U3VubnkuWWFuZyDmnajlhYk=?= <sunny.yang@siliconmotion.com>

On Mon, Aug 13, 2012 at 04:56:33PM +0800, Aaron.Chen  陈俊杰 wrote:
> 
> Since there is no response for the last mail. Maybe it didn't sent successfully. So I send it again. Here is the initial patch for siliconmotion kernel driver.

What's with the #ifdef 0 or #ifdef 1?

Why is there a bunch of ddkxxx something? Can those header files
be squashed together?
> 
> Aaron
> 


> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

