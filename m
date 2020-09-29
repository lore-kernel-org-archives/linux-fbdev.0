From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Tue, 29 Sep 2020 01:12:46 +0000
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
Message-Id: <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
 <20200928175956.GF24673@neutronstar.dyndns.org>
In-Reply-To: <20200928175956.GF24673@neutronstar.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Hostettler <textshell@uchuujin.de>
Cc: syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>, linux-fbdev@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Linus Torvalds <torvalds@linux-foundation.org>, gregkh@linuxfoundation.org, jirislaby@kernel.org, Peilin Ye <yepeilin.cs@gmail.com>

On 2020/09/29 2:59, Martin Hostettler wrote:
> On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
>> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
>> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
>>
> 
> It seems this is/was used by "svgatextmode" which seems to be at
> http://www.ibiblio.org/pub/Linux/utils/console/
> 
> Not sure if that kind of software still has a chance to work nowadays.
> 

Thanks for the information.

It seems that v.v_vlin = curr_textmode->VDisplay / (MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1)
and v.v_clin = curr_textmode->FontHeight . Thus, v.v_clin is font's height and seems to be non-zero.
But according to https://bugs.gentoo.org/19485 , people are using kernel framebuffer instead.

---------- SVGATextMode-1.10/SVGATextMode.c ----------

      /*
       * Resize the screen. Still needs LOTS more error checking to avoid dropping out in the middle, leaving
       * the user with a garbled screen.
       *
       * sresize will be TRUE when resizing tty's should be forced (due to the 2nd attempt do_VT_RESIZE will do
       * when not enough memory is free).
       *
       */

        /*
         * ALWAYS do a VT_RESIZE, even if we already did a VT_RESIZEX on a 1.3.3 or higher kernel,
         * until those kernel programmers make this unambiguous
         */

       if (do_VT_RESIZE(curr_textmode->cols, curr_textmode->rows, resize1x1)) sresize=TRUE;

       if (check_kernel_version(1,3,3, "VT_RESIZEX"))
         {
           /*
            * VDisplay must de divided by 2 for DoubleScan modes,
            * or VT_RESIZEX will fail -- until someone fixes the kernel
            * so it understands about doublescan modes.
            */
           if (do_VT_RESIZEX(curr_textmode->cols,
                             curr_textmode->rows,
                             curr_textmode->VDisplay / (MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1),
                             curr_textmode->FontHeight,
                             curr_textmode->HDisplay/8*curr_textmode->FontWidth,
                             curr_textmode->FontWidth, resize1x1)) sresize=TRUE;
         }

---------- SVGATextMode-1.10/ttyresize.c ----------

/*
 * if VT_RESIZEX not supported (i.e. when compiling on < 1.3.3 kernels), define it.
 * this is just te keep the compiler happy
 */

#ifndef VT_RESIZEX
#  define VT_RESIZEX  0x560A
   typedef struct vt_consize {
      ushort v_rows; ushort v_cols; ushort v_vlin; ushort v_clin; ushort v_vcol; ushort v_ccol;
    } vt_consize;
#endif


int do_VT_RESIZEX(int cols, int rows, int vlin, int clin, int vcol, int ccol, int allow1x1)
{
  struct vt_consize my_vt_size;      /* passes the new screen size on to the kernel */
  struct vt_consize dummy_vt_size = { 1 , 1 , 1 , 1 , 1 , 1 };
  int ram_needed = cols * rows * 2 * MAX_NR_CONSOLES;

  my_vt_size.v_rows = rows;
  my_vt_size.v_cols = cols;
  my_vt_size.v_vlin = vlin;
  my_vt_size.v_clin = clin;
  my_vt_size.v_vcol = vcol;
  my_vt_size.v_ccol = ccol;

  PDEBUG(("VT_RESIZEX(cols=%d,rows=%d,vlin=%d,clin=%d,vcol=%d,ccol=%d)\n",cols, rows, vlin, clin, vcol, ccol));

  return(generic_VT_RESIZE(&my_vt_size, &dummy_vt_size, allow1x1, ram_needed, VT_RESIZEX, "VT_RESIZEX"));
}
