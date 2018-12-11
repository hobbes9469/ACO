; Matthew Kang
; matthesk@fullerton.edu
; CPSC 481
; Project 3: ACO


; Grid for the ants to move on
(defvar grid '(("-----x-x----x--------x----x----x---------------x-x---x------")
               ("-x---x-x----x-x------x----x----xxxxxxxxx--xxxxxx-x---x------")
               ("-x---x-x-x-xx-xxxxx--xx--xx----x-x--x-x--------x-x---x-x-xxx")
               ("-x---x--------x------x----x--xxx-x----x------x-x-x---x-x-x--")
               ("-x-----x----x-xxxx--xx----x----x----x--xxx--xx-x-x---x---x--")
               ("-x---x-x--xx--x----x------xxx--x-x--x-x------x-x-x---x-x----")
               ("-x-----x----x-x----x-x--xxx--x-x-------------x-x-x---x------")
               ("-x---x------x------x-x--x-x--x-x-x--x-x------x-x-----xxxx-x-")
               ("-----x-x----x-x-xx-x-x--x-x--x-xxxxxx-xxx-xxxx-x-----x------")
               ("xxxxxxxx-xxx-xx------x--x----x-x---x----x----x-x-xxx-x-x-x--")
               ("-x-x----x---x-xx-x-x-x-------x-----xx--xx----x-----x-x---x--")
               ("--------------x------x----x----x---x----x----x-x-----x-x----")
               ("---xx-x-------x----x----x-x----x---x--x-x--xx--x---x-x-xx--x")
               ("-x------x---x-x-x-xxxx-x-xxxx----------------x-x-----x-x----")
               ("-x-x----x---x-x------x----x----x------x------x-----x-xxx-xxx")
               ("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxx-xxxxx------")
               ("-x--x-x---x-x---x--x-----x---x----x--x-------------x-x------")
               ("-x--x-x---x-x---x--x-----x-----x-xx--------x-xxx-xxx-x-xx-xx")
               ("-x--x-x---x-x---x--x-x-xxx---x----------x----------x-x------")
               ("----x-----x-x---x--x-x---------------x--x--x-------x-x------")
               ("----x-x---x-x------x-x---x-xxxxxx-xxxxxxxxxxxxxxxxx--x------")
               ("-x--x-----x-x--------x---x-x----------x---x--x-x---x-xxx-x-x")
               ("-x--x-x---x-x---x--x-x------xxxxx-xx-xx---x--x-------x-x----")
               ("-xx-xxxx--x-x---x--x-x---x-x--------x-x--------x---x-x---x-x")
               ("----x-----x-x---x--x-x---x-x---x--xxx-----x--x-x---x-x-x----")
               ("--x-x-------x---x--------x-x--x-----x-x---x----x---x-x------")
               ("--x-xxx-x-x-x---x--x-----x-x--x-------x---x--xx----x-x-xxx-x")
               ("--x-x-----x-x-xxxxxxx-xxxx-xxx-xxx-xx-x---x-x--x---x-x------")
               ("--x-x-----x-x------------x----------x-x---x----x---x-xxxxx--")
               ("----xx-x-xx-xx-xxxxxx-xxxx-x--xxxx--x-----x-x--x---x--------")
               ("xx--x-----x-x------------x-x--------x-x--------x---x-x------")
               ("----x-----x-xxxxx-xxx-xxxx-x-----x----x---x-x--x---x-x------")
               ("x-x-x-----x-x---x--x-----xxxx-xxxxxxxxxxx-xxxxxxxxxx-xx-x-xx")
               ("----xxxx--x--------xx-x-xx--x-x------------------x-x-x----x-")
               ("----x-----x-x---x--x---x-x--x-x-------x---x------x-x-x----x-")
               ("-xx-------x-x------------x--x---xxxxx-----x-x-xxx--x-x--xxx-")
               ("----x--x--x-x---x------x-x------------x------------x-x----x-")
               ("--xx---x--------x--x-----x----x-------x---x------x-x-x--xxx-")
               ("----x--x--xxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxx------")
               ("----x--x--x-------------------------------------------------")))


; Scent values for each cell, to be updated as ACO runs. 
; Each cell's scent inittialized to 0
(defvar scent '((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
				(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)))




; Ant class definition
; Contains x and y coordinate of the ant, path history,
; and flag for if the ant found food (boolean)
(defclass Ant ()
  ((x :initarg :x
      :accessor ant-x)
   (y :initarg :y
      :accessor ant-y)
   (tabu :accessor ant-tabu)
   (food :accessor ant-food)))


; Returns list of possible, valid moves for the ant
; depending on its current position
(defmethod movelist (Ant)
  (let ((ml '())
        (xpos (ant-x Ant))
        (ypos (ant-y Ant)))
    (loop for sq in (pm xpos ypos)                   ; For each possible orthogonal move...
          do (if (vm (nth 0 sq) (nth 1 sq))          ; if it is a valid move...
                 (setq ml (append ml (list sq)))))   ; append it to the list.
    ml                                               ; Return the list
    ))


; Method to have the ant take one step on the 
; coordinate with the best heuristic
(defmethod antstep (Ant)
  (let ((next (bestsquare Ant)))
    (setf (ant-tabu Ant) (append (list (list (ant-x Ant) (ant-y Ant))) (ant-tabu Ant)))  ; Add current square to top of path history
    (setf (ant-x Ant) (nth 0 next))         ; Set current ant x and y coordinates to the next x and y coordinates
    (setf (ant-y Ant) (nth 1 next))))



; Function deltamax for heuristic method when the ant is foraging
; (x1 y1) is the ant's coordinate and (x2 y2) is the candidate coordinate
(defun deltamax (x1 y1 x2 y2)
  (- (max x2 y2) (max x1 y1)))      ; Difference between max of ant coord and max of candidate coord


; Function deltasum for heuristic method when ant is returning
; (x1 y1) and (x2 y2) follow as in deltamax
(defun deltasum (x1 y1 x2 y2)
  (- (+ x2 y2) (+ x1 y1)))          ; Difference between coord sum of candidate and coord sum of ant position   


; Function to calculate heuristic value of a candidate point
(defun heur (ant cx cy)
  (let ((R (/ (- (random 161) 80) 100))   ; Random fuzzing value
        (SK 0.1)                          ; Scent balancing factor
        (food (ant-food ant))             ; "Food Found" flag for ant
        (M)                               ; Mode value, to be determined later
        )
    (if (equal food NIL)                                     ; If food flag is NIL...
        (setq M (deltamax (ant-x ant) (ant-y ant) cx cy))    ; Use deltamax as Mode
        (setq M (deltasum (ant-x ant) (ant-y ant) cx cy)))   ; Else, use delta sum as Mode
    (+ M (* SK (getscent cx cy)) R)))               ; Return the result of the heuristic formula


; Function that takes an Ant and returns the best square
; to move to based on heuristic values~~~STILL WORKING ON~~~
(defun bestsquare (ant)
  (let ((ml (movelist ant))         ; Ant's possible candidate moves
        (hl '())                    ; List of heuristic values for the movelist
        (tabu '())                  ; Last 8 squares of ant's path to avoid
        (fml '()))                  ; Final move list with tabu squares removed
    (if (<= 8 (length (ant-tabu ant)))            ; Set the tabu list
        (setq tabu (subseq (ant-tabu ant) 0 8))
        (setq tabu (ant-tabu ant)))
    (loop for m in ml                               ; For each square on the movelist
         do (if (not (member m tabu :test 'equal))  ; if it is not in the tabu list
                (setq fml (append (list m) fml))))  ; add to final move list
    (if (equal 0 (length fml))         ; If final move list is empty
        (setq fml ml))                 ; change final move list to current move list (ignore tabu)
    (loop for f in fml                                                      ; For each square on the final move list
          do (setq hl (append hl (list (heur ant (nth 0 f) (nth 1 f))))))   ; Apply heuristics and save
    (nth (position (apply 'max hl) hl) fml)))                               ; Return the move with the highest heuristic value


; Function to return list of possible orthogonal moves from (x y)
; whether they are valid or not
(defun pm (x y)
  (let ((possible '()))
    (setq possible (append possible (list (list (- x 1) y))))  ; Gather all orthogonal moves
    (setq possible (append possible (list (list x (- y 1)))))
    (setq possible (append possible (list (list (+ x 1) y))))
    (setq possible (append possible (list (list x (+ y 1)))))
    possible))                                                 ; Return the list of orthogonal moves


; Function to check if move is valid (using boundary rules and 'X' on grid)
; Returns T if space is a valid move, NIL if not
(defun vm (x y)
  (if (and (<= x 59) (>= x 0) (<= y 39) (>= y 0)    ; If x and y are within the grid boundaries
           (equal (getsquare x y) #\-))             ; and the square is not on an "x" space
      T NIL))                                       ; T if so, NIL otherwise

  
; Function to get a particular square from the grid
; Takes x and y coordinate of the grid, returns char of the coordinate
(defun getsquare (x y)
  (char (car (nth y grid)) x))


; Function to get a particular scent value
; based on the input (x y) coordinate
(defun getscent (x y)
  (nth x (nth y scent)))


; ---------------
; Creating an ant
(defvar ant0)

(setq ant0 (make-instance 'ant
                          :x 0 :y 0))   ; Initialize x and y to (0 0)
(setf (ant-tabu ant0) '())              ; Initialize tabu with empty list
(setf (ant-food ant0) NIL)              ; Initialize food flag to NIL






(format t "(x, y): (~D, ~D)~%" (ant-x ant0) (ant-y ant0))


(defvar steps 10000)

(setq steps 10000)


(loop while (/= steps 0)
      do (antstep ant0)
         (format t "(X, Y): (~D, ~D)~%" (ant-x ant0) (ant-y ant0))
         (setq steps (- steps 1)))



; TODO: Implement avoiding the last T = 8 Tabu cells for the ant
;       Otherwise, the ant will get stuck around (4 8)
;       Probably should be done in the "bestsquare" function

