From: Daniel Mack <daniel@zonque.org>
Date: Tue, 19 Jun 2018 20:12:57 +0000
Subject: Re: [PATCH v2] video: fbdev: pxafb: zero allocated memory for video modes
Message-Id: <bbbf81c8-86aa-300d-0672-fe986c6e21fb@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180619131332.23741-1-daniel@zonque.org>
In-Reply-To: <20180619131332.23741-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, June 19, 2018 10:11 PM, Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
>> When parsing the video modes from DT properties, make sure to zero out
>> memory befor using it. This is important because not all fields in the mode
> s/befor/before/
> 

Yeah, seen this too after sending. Should I resend, or can this be 
amended when applying?

 > This taken care of ...
 > Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks,
Daniel


